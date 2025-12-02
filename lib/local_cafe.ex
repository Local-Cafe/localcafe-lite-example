defmodule LocalCafe do
  use Phoenix.Component
  import Phoenix.HTML

  alias LocalCafe.Menu
  alias LocalCafe.Site
  alias LocalCafe.Location

  def item(assigns) do
    ~H"""
    <.layout site_settings={@site_settings} locations={@locations} title={@item.title}>
      <article class="menu-item">
        <header class="menu-item-header">
          <h1 class="menu-item-title"><%= @item.title %></h1>
          <div class="menu-item-prices" :if={@item.prices && is_binary(@item.prices)}>
            <span class="price-option"><%= @item.prices %></span>
          </div>
          <div class="menu-item-prices" :if={@item.prices && is_list(@item.prices)}>
            <span class="price-option" :for={{k, v} <- @item.prices}>
              <%= k %>: <%= v %>
            </span>
          </div>
          <p class="menu-item-description"><%= @item.description %></p>
          <ul class="menu-item-tags">
            <li class="menu-tag" :for={tag <- @item.tags}>
              <a href={"/#filter:#{tag}"}><%= tag %></a>
            </li>
          </ul>
        </header>
        <img :if={@item.image} src={@item.image} alt={@item.title} class="menu-item-image" />
        <div class="menu-item-body">
          <%= raw @item.body %>
        </div>
        <div class="menu-item-actions">
          <a href="/" class="btn btn-primary">Back to Menu</a>
        </div>
      </article>
    </.layout>
    """
  end

  def index(assigns) do
    ~H"""
    <.layout site_settings={@site_settings} locations={@locations} title={@site_settings.title}>
      <div class="menu-hero">
        <div class="hero-slideshow" :if={@site_settings.hero_image && is_list(@site_settings.hero_image)}>
          <img
            :for={{img, idx} <- Enum.with_index(@site_settings.hero_image)}
            src={img}
            class={"hero-slide #{if idx == 0, do: "active", else: ""}"}
          />
        </div>
        <img src={@site_settings.hero_image} :if={@site_settings.hero_image && is_binary(@site_settings.hero_image)} />
        <p :for={hero <- @site_settings.hero}>{hero}</p>
      </div>
      <section id="menu" class="menu-section">
        <h2 class="menu-section-heading">Our Menu</h2>
        <div class="menu-filters">
          <button class="filter-btn active" data-filter="all">All</button>
          <button :for={tag <- @tags} class="filter-btn" data-filter={tag}><%= tag %></button>
        </div>
        <div class="menu-grid">
        <article class="menu-card" :for={item <- @items} data-tags={Enum.join(item.tags, ",")}>
          <a href={item.path}><img :if={item.image} src={item.image} alt={item.title} class="menu-card-image" /></a>
          <div class="menu-card-header">
            <h2 class="menu-card-title">
              <a href={item.path}><%= item.title %></a>
            </h2>
            <div class="menu-card-prices" :if={item.prices && is_binary(item.prices)}>
              <span class="price-option"><%= item.prices %></span>
            </div>
            <div class="menu-card-prices" :if={item.prices && is_list(item.prices)}>
              <span class="price-option" :for={{k, v} <- item.prices}>
                <%= k %>: <%= v %>
              </span>
            </div>
          </div>
          <p class="menu-card-description"><%= item.description %></p>
          <ul class="menu-card-tags">
            <li class="menu-tag" :for={tag <- item.tags}>
              <a href={"/#filter:#{tag}"}><%= tag %></a>
            </li>
          </ul>
        </article>
      </div>
      </section>

      <div class="home-content">
        <%= raw @site_settings.body %>
      </div>
    </.layout>
    """
  end

  def layout(assigns) do
    ~H"""
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="description" content={@site_settings.description} />
        <title>{@title} | {@site_settings.site_name}</title>

        <%!-- OpenGraph meta tags --%>
        <meta property="og:title" content={"#{@title} | #{@site_settings.site_name}"} />
        <meta property="og:description" content={@site_settings.description} />
        <meta
          property="og:image"
          content={if @site_settings.domain, do: "#{@site_settings.domain}#{@site_settings.image}", else: @site_settings.image}
        />
        <meta property="og:type" content="website" />
        <meta property="og:site_name" content={@site_settings.site_name} />

        <%!-- Twitter Card meta tags --%>
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:title" content={"#{@title} | #{@site_settings.site_name}"} />
        <meta name="twitter:description" content={@site_settings.description} />
        <meta
          name="twitter:image"
          content={if @site_settings.domain, do: "#{@site_settings.domain}#{@site_settings.image}", else: @site_settings.image}
        />

        <link rel="stylesheet" href="/assets/css/app.css" />
        <script defer src="/assets/js/app.js"></script>
      </head>
      <body>
        <header class="site-header">
          <nav class="site-nav">
            <a href="/" class="site-logo">
              <img :if={@site_settings.logo} src={@site_settings.logo} alt={@site_settings.site_name} class="site-logo-image" />
              <span class="site-logo-text">{@site_settings.site_name}</span>
            </a>
            <input type="checkbox" id="nav-toggle" class="nav-toggle" />
            <label for="nav-toggle" class="nav-toggle-label">
              <span></span>
              <span></span>
              <span></span>
            </label>
            <ul class="nav-links">
              <li><a href="/#menu">Menu</a></li>
              <li><a href="#locations">Locations</a></li>
            </ul>
          </nav>
        </header>
        <main class="site-main">
          <%= render_slot(@inner_block) %>
        </main>
        <footer class="site-footer" id="locations">
          <div class="locations-grid">
            <div class="location-card" :for={location <- @locations}>
              <h3 class="location-name"><%= location.name %></h3>
              <div class="location-description"><%= Phoenix.HTML.raw(location.body) %></div>
              <div class="location-content">
                <div class="location-info">
                  <div class="location-section">
                    <h4>Address</h4>
                    <p><%= location.street %></p>
                    <p><%= location.city_state %></p>
                  </div>

                  <div class="location-section">
                    <h4>Hours</h4>
                    <p :for={hour <- location.hours}><%= hour %></p>
                  </div>

                  <div class="location-section">
                    <h4>Contact</h4>
                    <p>Phone: <%= location.phone %></p>
                    <p>Email: <%= location.email %></p>
                  </div>
                </div>
                <div class="location-map" :if={location.latitude && location.longitude}>
                  <iframe
                    title="openstreetmaps"
                    width="600"
                    height="400"
                    frameborder="0"
                    scrolling="no"
                    marginheight="0"
                    marginwidth="0"
                    src={"https://www.openstreetmap.org/export/embed.html?bbox=#{String.to_float(location.longitude) - 0.0005},#{String.to_float(location.latitude) - 0.0005},#{String.to_float(location.longitude) + 0.0005},#{String.to_float(location.latitude) + 0.0005}&layer=mapnik&marker=#{location.latitude},#{location.longitude}"}
                  ></iframe>
                </div>
              </div>
            </div>
          </div>
          <div class="footer-bottom">
            <p>&copy; 2025 {@site_settings.site_name}. All rights reserved.</p>
            <a href="https://localcafe.org" class="built-with-badge" target="_blank" rel="noopener noreferrer">
              <img src="/images/localcafe.svg" alt="LocalCafe" class="built-with-logo" />

              <span>Built with</span>
              <span>localcafe.org</span>
            </a>
          </div>
        </footer>
      </body>
    </html>
    """
  end

  @output_dir Application.app_dir(:local_cafe, "priv/output")

  def build() do
    items = Menu.all_items()
    tags = Menu.all_tags()
    locations = Location.all_locations()

    render_file(
      "index.html",
      index(%{
        items: items,
        tags: tags,
        site_settings: Site.site_settings(),
        locations: locations
      })
    )

    for item <- items do
      dir = Path.dirname(item.path)

      if dir != "." do
        File.mkdir_p!(Path.join([@output_dir, dir]))
      end

      render_file(
        item.path,
        item(%{item: item, site_settings: Site.site_settings(), locations: locations})
      )
    end

    :ok
  end

  def render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    output = Path.join([@output_dir, path])
    File.write!(output, safe)
  end
end

#   /priv/home.md
#
#   This file repersents the site's configration and the home page's content
#
#   site_name - This will show in the title tag in all pages
#
#   title - The prefix of the title on the home page
#
#   description - This will show in the header's description meta tag, used for SEO
#
#   image - The preivew image seen in the header's meta tags used by social networks and SEO
#
#   logo - This is the companies branding seen in the top navigation bar.
#   Warning. It's advised to use a 100x100 png
#
#   hero - A list of strings that are using on the landing section of the home page.
#   Each element in the list is a line.
#
#   hero_image - a list of images relative to the domain for use in the slide show on the home page
#
#   domain - the site's main url.
#
#   social_links - A list of social media profiles to display as icons in the footer.
#   Available icons: bluesky, doordash, facebook, github, instagram, tiktok, ubereats, x, yelp
#   Format: [platform: "url", ...]


%{
  site_name: "LocalCafe.org Lite",
  title: "Home",
  description: "A static site generator for local restaurants and cafes",
  image: "/images/example-logo.png",
  logo: "/images/example-logo.png",
  hero: ["Example hero text line 1", "Examle Hero text line 2"],
  hero_image: "/images/example-hero.png",
  domain: "https://lite.localcafe.org/",
  social_links: [
    instagram: "https://instagram.com/example",
    facebook: "https://facebook.com/example",
    x: "https://x.com/example"
  ]
}
---

## This is a H2 tag

Ed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.

### This is a H3 tag

Sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.

* Some list item 1
* Some list item 2
* Some list item 3

basic [link](https://example.com)

> Some quote

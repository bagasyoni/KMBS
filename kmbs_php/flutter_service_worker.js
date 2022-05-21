'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "b211060275be81917485d7bff91d8875",
"assets/assets/file/account.json": "c35afcba40f9e3825397083bab2edde0",
"assets/assets/images/background.png": "5e9e3c919ad79d52d33da581106869fa",
"assets/assets/images/background2.png": "d4a197ea155e2d6af6d830b0df83e7df",
"assets/assets/images/banner.png": "7e8abe439e4c884ff0ae2262f79a4f70",
"assets/assets/images/ic_add.png": "cbe3f4591c57c1dbe04890491b72c62a",
"assets/assets/images/ic_back.png": "dec45df319bb2548bed645f048cb49e1",
"assets/assets/images/ic_delivered.png": "9e4d28d826cfcfdd7298d0ce61b2d089",
"assets/assets/images/ic_diskon.png": "aca51ae35084d10a259a8d75e69b9333",
"assets/assets/images/ic_download.png": "d05b42750537e79130349064201b08d3",
"assets/assets/images/ic_edit.png": "8d79bd92434d03de34c0ed2a3b9e731c",
"assets/assets/images/ic_excel.png": "84c098054b2baeef50d3b1af45c04909",
"assets/assets/images/ic_hapus.png": "e618ba1051f1228c055f081216df5fd4",
"assets/assets/images/ic_home.png": "78192fac8d26ad148c60b3f34fa894d1",
"assets/assets/images/ic_list.png": "11ec0c60440764ad37a9db236abecf19",
"assets/assets/images/ic_loading.png": "2a3f8c9e276d90de256b26021b685a4c",
"assets/assets/images/ic_logo.png": "ee832ae93b6b317ea21eceec8cc7253f",
"assets/assets/images/ic_logout.png": "70fc986398755fd66240de0a3e1e7b1a",
"assets/assets/images/ic_more.png": "8ec73b6b8c039056ed4b42f5e6e52939",
"assets/assets/images/ic_more2.png": "b8c751ea0da37cdd64b1282570b504a7",
"assets/assets/images/ic_ongkir.png": "e6e391144c397897be943019dccec051",
"assets/assets/images/ic_password.png": "91ec5dae081b3664847606d21634d3ae",
"assets/assets/images/ic_pdf.png": "ca3446cc0236236922fc27fa7a27fbb0",
"assets/assets/images/ic_pembelian.png": "cdf70332261adf815f5779ddd38a750c",
"assets/assets/images/ic_penjualan.png": "c8cd2d917966b2079a7bc4f6db6fc931",
"assets/assets/images/ic_po.png": "601acc964163596d196902fcc8e44d8d",
"assets/assets/images/ic_print.png": "abb5805d1f3786455be9498496cea8c1",
"assets/assets/images/ic_save.png": "945632eccc295622e0c781a4a0f96b98",
"assets/assets/images/ic_search.png": "3a850a913343549caf8ae6b69d573148",
"assets/assets/images/ic_setting.png": "f629b278bf31681b561c4f8ffb0f3cad",
"assets/assets/images/ic_so.png": "56f603eda401c0a4872f99f3e3d24c29",
"assets/assets/images/ic_staff.png": "b36cfca8642623700cbe1c14b00c2c0c",
"assets/assets/images/ic_success.png": "57e96cfa4cdddf9492d76930632d120b",
"assets/assets/images/ic_tanggal.png": "861b4bbab8d731ae86a91780f22ebb8d",
"assets/assets/images/ic_tax.png": "bd9522c9aa0cb05472aa243d026834ea",
"assets/assets/images/ic_user.png": "b3be999f4dbc7358a63f006ecd0889a0",
"assets/assets/images/ic_user_hijau.png": "c6f8ee1e51ac2d4376e16affcb7356af",
"assets/assets/images/ic_user_warna.png": "a2e6deb63bfc94ba71dbcf0e03b026d7",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/NOTICES": "8683360e3aadf879beefe2f02e86c9ab",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "92a950319206f04133f5de2ae001185f",
"/": "92a950319206f04133f5de2ae001185f",
"main.dart.js": "dda4013a2634e15a8b861bdc5149a979",
"manifest.json": "25632cd7ca7db7ceb0ba08c55250dacf",
"version.json": "4cfde9af8d9e39714d81b4c6fe3724e0"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

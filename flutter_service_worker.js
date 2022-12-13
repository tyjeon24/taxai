'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "manifest.json": "2a3bcc589ef1f1d45e05bea16e42a019",
"version.json": "a0e08589381573a60cfdde860c212693",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"index.html": "4ed8dd3d5bd481d66829b2b8f909f76d",
"/": "4ed8dd3d5bd481d66829b2b8f909f76d",
"main.dart.js": "10881dc11f2cb0b7b2340c9c2288842b",
"assets/NOTICES": "99cf0c788e68b3dcf33146f8f60cadd0",
"assets/packages/amplify_secure_storage_dart/lib/src/worker/workers.min.js.map": "3c90f37ee9b84827d603250f850c9b32",
"assets/packages/amplify_secure_storage_dart/lib/src/worker/workers.min.js": "97d12322ae9750fab47389aa851a5e53",
"assets/packages/amplify_authenticator/assets/social-buttons/google.png": "a1e1d65465c69a65f8d01226ff5237ec",
"assets/packages/amplify_authenticator/assets/social-buttons/SocialIcons.ttf": "1566e823935d5fe33901f5a074480a20",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/amplify_auth_cognito_dart/lib/src/workers/workers.min.js.map": "75c06d3e231875606c86461004977a85",
"assets/packages/amplify_auth_cognito_dart/lib/src/workers/workers.min.js": "04e573531e51d99f7128a77ae1c480f5",
"assets/shaders/ink_sparkle.frag": "83c076d55fdbf5e6f73f29c79926992c",
"assets/FontManifest.json": "364c68f177e17f7f1e62f1ab975300e2",
"assets/AssetManifest.json": "809c4a6de0a5fc2e0007bb4499c3e8d1",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/fonts/NotoSansKR-Bold.otf": "e2406ff1791c401bc93e73d9e44e6d2b",
"assets/fonts/NotoSansKR-Medium.otf": "32666ae307200b0bcab5553590672bb1",
"assets/fonts/NotoSansKR-Black.otf": "05c077164c27fa722dcafe63ed38355e",
"assets/assets/tax_consulting_illustration.jpg": "874d2f9eb503eda594a44ae5296505be",
"assets/assets/icons/logo_color_row.svg": "cd1b23ee92f67092c2174bf369f70d34",
"assets/assets/icons/logo_color.svg": "d0af369193a58462ca00924347aabaa1",
"assets/assets/animated_money.gif": "58fa8fa24d3dfab0c39f7ae56564ea57",
"assets/assets/homepage_image.png": "8efb13b7691c7a4733e60dc9773319b5",
"assets/assets/homepage_image2.png": "13ba6ae9fa68879fcdee3272c23aafba",
"assets/assets/animated_document.gif": "255b1a15bffe9eba3239dd0833ce1b00",
"assets/assets/homepage/background3_1.png": "29c1d2d0ea93a84ba2c51571cad2c81e",
"assets/assets/homepage/background.png": "20c4a05363e5eab554ae7e359d4d4095",
"assets/assets/homepage/backgroundtext.png": "07a3e8e16dc48f1dbdcc160074918310",
"assets/assets/homepage/background3_2.png": "4ad593559780c38b145a3b4f2597bc96",
"assets/assets/homepage/background2text.png": "711500135258ddcf94b73765c2e4a8bb",
"assets/assets/homepage/background2.png": "f3a9b1be25f5d46fbf2283dd16563049",
"assets/assets/homepage/compare.png": "c2377f05c10bdb7fbae95fd96f39de61",
"assets/assets/animtaed_consult.gif": "7afda4d1be091752f33abbbaf4d1c29b",
"assets/assets/animated_inherit.gif": "7ab8fed5f3a7a46d9f48554b0bf69fc0"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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

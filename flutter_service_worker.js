'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "f099cb4d53f588b3bbb604577355e399",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"manifest.json": "2a3bcc589ef1f1d45e05bea16e42a019",
"icons/Icon-512.png": "9670870ab9fd90855dbdf05ef52b11d7",
"icons/Icon-192.png": "d9b3a0b1b6bb0e7867311ced4b0fd339",
"favicon.ico": "26939f0ba900974b16ac212d56a123f0",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"assets/AssetManifest.json": "d70d0189555b7695d7ca5175c938a719",
"assets/shaders/ink_sparkle.frag": "83c076d55fdbf5e6f73f29c79926992c",
"assets/packages/amplify_authenticator/assets/social-buttons/SocialIcons.ttf": "1566e823935d5fe33901f5a074480a20",
"assets/packages/amplify_authenticator/assets/social-buttons/google.png": "a1e1d65465c69a65f8d01226ff5237ec",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/amplify_auth_cognito_dart/lib/src/workers/workers.min.js": "ebfc9e34cec312ac2869d0aad0a85ea4",
"assets/packages/amplify_auth_cognito_dart/lib/src/workers/workers.min.js.map": "8dce005059f522055db3a73de8aba393",
"assets/packages/amplify_secure_storage_dart/lib/src/worker/workers.min.js": "97d12322ae9750fab47389aa851a5e53",
"assets/packages/amplify_secure_storage_dart/lib/src/worker/workers.min.js.map": "3c90f37ee9b84827d603250f850c9b32",
"assets/FontManifest.json": "364c68f177e17f7f1e62f1ab975300e2",
"assets/fonts/NotoSansKR-Medium.otf": "32666ae307200b0bcab5553590672bb1",
"assets/fonts/NotoSansKR-Black.otf": "05c077164c27fa722dcafe63ed38355e",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/fonts/NotoSansKR-Bold.otf": "e2406ff1791c401bc93e73d9e44e6d2b",
"assets/assets/animated_money.gif": "58fa8fa24d3dfab0c39f7ae56564ea57",
"assets/assets/homepage_image.png": "8efb13b7691c7a4733e60dc9773319b5",
"assets/assets/icons/logo_color_row.svg": "cd1b23ee92f67092c2174bf369f70d34",
"assets/assets/icons/logo_color.svg": "d0af369193a58462ca00924347aabaa1",
"assets/assets/tax_consulting_illustration.jpg": "874d2f9eb503eda594a44ae5296505be",
"assets/assets/animated_inherit.gif": "7ab8fed5f3a7a46d9f48554b0bf69fc0",
"assets/assets/animtaed_consult.gif": "7afda4d1be091752f33abbbaf4d1c29b",
"assets/assets/animated_document.gif": "255b1a15bffe9eba3239dd0833ce1b00",
"assets/assets/homepage/mobile3.png": "62ee35e7fee6a0f0fdf3a95bfd06e295",
"assets/assets/homepage/desktop6_3.png": "9f92089522f66428a79eb7f4a53f5d66",
"assets/assets/homepage/mobile5.png": "68bc1330eed6df173b1db0bbfe9171a2",
"assets/assets/homepage/mobile2.png": "1a8fb39e8335e6a4a51ca12938f90c62",
"assets/assets/homepage/desktop6_2.png": "96c4805c3ca154029c0cb740efc4dbb7",
"assets/assets/homepage/desktop4.png": "c2377f05c10bdb7fbae95fd96f39de61",
"assets/assets/homepage/desktop5_1.png": "4be40034cdab48608e2955f2c9d8fcc2",
"assets/assets/homepage/desktop5_2.png": "a4fb778c1c6cfbc1ce276a89d550681c",
"assets/assets/homepage/desktop1_text.png": "07a3e8e16dc48f1dbdcc160074918310",
"assets/assets/homepage/desktop3_1.png": "29c1d2d0ea93a84ba2c51571cad2c81e",
"assets/assets/homepage/desktop2_text.png": "711500135258ddcf94b73765c2e4a8bb",
"assets/assets/homepage/desktop6.png": "6784b7c5215d9b67999ef075b030f816",
"assets/assets/homepage/desktop7.png": "225585667b80842c1af3a89e98ef7c80",
"assets/assets/homepage/desktop2.png": "f3a9b1be25f5d46fbf2283dd16563049",
"assets/assets/homepage/mobile4.png": "cfc9537406e19ef163cbdc233556d054",
"assets/assets/homepage/mobile1.png": "364c3bfa690dbb2e59093fb8bbdb7a0d",
"assets/assets/homepage/desktop3_2.png": "4ad593559780c38b145a3b4f2597bc96",
"assets/assets/homepage/mobile6.png": "4c7e7a8661cb5a02385f3928660cf7fb",
"assets/assets/homepage/desktop6_1.png": "8a3078b3d876408f4df0ebaa5d23ca03",
"assets/assets/homepage/mobile7.png": "cef0506586bb59e6af29163ec09ffcdb",
"assets/assets/homepage/desktop1.png": "20c4a05363e5eab554ae7e359d4d4095",
"assets/assets/homepage_image2.png": "13ba6ae9fa68879fcdee3272c23aafba",
"assets/NOTICES": "be0304528e3ab0123635a2abaf0b398f",
"index.html": "1545bddb8e75658090d16cc2bb3c947b",
"/": "1545bddb8e75658090d16cc2bb3c947b",
"version.json": "a97d75433f7ffb6b9b800b93bee24faa"
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

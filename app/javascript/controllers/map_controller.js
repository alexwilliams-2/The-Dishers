import { Controller } from "@hotwired/stimulus";
import axios from "axios"; // Make sure to import the Axios library

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  };

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
    });

    this.#addMarkersToMap();
    this.#fitMapToMarkers();
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach((marker) =>
      bounds.extend([marker.lng, marker.lat])
    );
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const customMarker = document.createElement("div");
      customMarker.innerHTML = marker.marker_html;

      const mapMarker = new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map);

      // Add a hover event listener to fetch and display pop-up content dynamically
      mapMarker.getElement().addEventListener("mouseenter", () => {
        // Make an Ajax request to fetch the pop-up content
        axios
          .get("/fetch-popup-content", {
            params: { markerId: marker.id },
          })
          .then((response) => {
            const popupContent = response.data; // Assuming the response contains HTML content
            const popup = new mapboxgl.Popup()
              .setLngLat([marker.lng, marker.lat])
              .setHTML(popupContent)
              .addTo(this.map);
          })
          .catch((error) => {
            console.error("Error fetching pop-up content:", error);
          });
      });
    });
  }

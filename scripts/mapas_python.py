import xarray as xr
import matplotlib.pyplot as plt
import cmocean
import numpy as np

# === abrir dados ===
topo = xr.open_dataset("topo.grd")
freeair = xr.open_dataset("freeair.grd")
b267 = xr.open_dataset("bouguer_267.grd")
b290 = xr.open_dataset("bouguer_290.grd")

z_topo = topo["z"]
z_free = freeair["z"]
z_b267 = b267["z"]
z_b290 = b290["z"]

# === máscaras ===
continente = z_topo >= 0
plataforma = (z_topo < 0) & (z_topo >= -200)
oceano = z_topo < -200

# === função única (não mexe mais nisso) ===
def plotar(data, titulo, cmap, vmin, vmax):

    fig, ax = plt.subplots(figsize=(10,8))

    # dados (oceano)
    im = ax.pcolormesh(
        topo["lon"], topo["lat"],
        data.where(oceano),
        cmap=cmap,
        vmin=vmin, vmax=vmax,
        shading="auto"
    )

    # plataforma (branco)
    ax.pcolormesh(
        topo["lon"], topo["lat"],
        np.where(plataforma, 1, np.nan),
        cmap="gray",
        vmin=0, vmax=1,
        shading="auto"
    )

    # continente (cinza)
    ax.pcolormesh(
        topo["lon"], topo["lat"],
        np.where(continente, 0.6, np.nan),
        cmap="gray",
        vmin=0, vmax=1,
        shading="auto"
    )

    # linha de costa
    ax.contour(
        topo["lon"], topo["lat"], z_topo,
        levels=[0],
        colors="black",
        linewidths=0.5
    )

    # colorbar ajustada
    cbar = plt.colorbar(im, ax=ax, shrink=0.7, aspect=25)
    cbar.set_label(titulo)

    ax.set_title(titulo)
    ax.set_xlabel("Longitude")
    ax.set_ylabel("Latitude")

    ax.set_aspect('equal')

    plt.show()


# === TOPO (batimetria) ===
plotar(z_topo, "Batimetria (m)", cmocean.cm.deep, -6000, 0)

# === FREE-AIR ===
plotar(z_free, "Free-Air (mGal)", cmocean.cm.balance, -100, 100)

# === BOUGUER 2.67 ===
plotar(z_b267, "Bouguer 2.67 (mGal)", cmocean.cm.balance, -200, 200)

# === BOUGUER 2.90 ===
plotar(z_b290, "Bouguer 2.90 (mGal)", cmocean.cm.balance, -200, 200)
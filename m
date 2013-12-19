From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: wm5110: Expose DRE control registers
Date: Thu, 19 Dec 2013 09:39:28 +0000
Message-ID: <20131219093928.GB27373@lee--X1>
References: <1387444262-26456-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387444262-26456-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: broonie@kernel.org, sameo@linux.intel.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Dec 2013, Charles Keepax wrote:

> Certain use-cases require the DRE to be disabled so expose registers
> necessary to control the DRE enables.
>=20
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  drivers/mfd/wm5110-tables.c           |    2 ++
>  include/linux/mfd/arizona/registers.h |    4 ++++
>  2 files changed, 6 insertions(+), 0 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

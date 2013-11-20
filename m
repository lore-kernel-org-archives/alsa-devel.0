From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/4] mfd: wm5110: Make DSP memories readable
Date: Wed, 20 Nov 2013 09:17:32 +0000
Message-ID: <20131120091732.GB30012@lee--X1>
References: <1384877043-5640-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1384877043-5640-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384877043-5640-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Nov 2013, Charles Keepax wrote:

> Expose the memory regions used by the DSP cores on WM5110 as readable
> and volatile.
>=20
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  drivers/mfd/wm5110-tables.c |   69 +++++++++++++++++++++++++++++++++=
+++++++--
>  1 files changed, 65 insertions(+), 4 deletions(-)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

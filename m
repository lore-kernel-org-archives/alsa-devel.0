From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/7] mfd: arizona: Remove audio related device tree code
Date: Tue, 5 Sep 2017 08:23:29 +0100
Message-ID: <20170905072329.re7ucxued2ryx7uc@dell>
References: <20170904154154.4395-1-ckeepax@opensource.cirrus.com>
 <20170904154154.4395-5-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170904154154.4395-5-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

On Mon, 04 Sep 2017, Charles Keepax wrote:

> This code has now been moved to the audio subsystem so is no longer
> required in the MFD code.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/arizona-core.c | 132 +--------------------------------------------
>  1 file changed, 1 insertion(+), 131 deletions(-)

I will require pull-request for this patch, but:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

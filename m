From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 6/7] ASoC: arizona: Add support for setting the output
 volume limits
Date: Tue, 5 Sep 2017 08:22:15 +0100
Message-ID: <20170905072215.cs2xsqu4ssiy4btz@dell>
References: <20170904154154.4395-1-ckeepax@opensource.cirrus.com>
 <20170904154154.4395-7-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170904154154.4395-7-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

On Mon, 04 Sep 2017, Charles Keepax wrote:

> The output volume limits allow signals to be limited to specific levels
> appropriate for the hardware attached. As this is a property of the
> hardware itself these will be configured through device tree.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  include/linux/mfd/arizona/pdata.h |  3 +++

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

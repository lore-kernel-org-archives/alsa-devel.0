From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH v3 00/30] Update cros_ec_commands.h
Date: Wed, 22 May 2019 06:53:23 +0100
Message-ID: <20190522055323.GD4574@dell>
References: <20190509211353.213194-1-gwendal@chromium.org>
 <2741579da03893d2d4e7ad7f5fc42a506a82f380.camel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2741579da03893d2d4e7ad7f5fc42a506a82f380.camel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, enric.balletbo@collabora.com, bleung@chromium.org, groeck@chromium.org, jic23@kernel.org, broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com, linux-iio@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 21 May 2019, Fabien Lahoudere wrote:

> Le jeudi 09 mai 2019 à 14:13 -0700, Gwendal Grignou a écrit :
> > The interface between CrosEC embedded controller and the host,
> > described by cros_ec_commands.h, as diverged from what the embedded
> > controller really support.
> > 
> > The source of thruth is at
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> > 
> > That include file is converted to remove ACPI and Embedded only code.
> 
> Hi, 
> 
> I reviewed patches of the series and they looks good to me.
> 
> Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>

Thanks Fabien.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

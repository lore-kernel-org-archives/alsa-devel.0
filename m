From: Mylene Josserand <mylene.josserand@free-electrons.com>
Subject: Re: [PATCH 02/14] clk: ccu-sun8i-a33: Add CLK_SET_RATE_PARENT to
 ac-dig
Date: Wed, 5 Oct 2016 11:37:53 +0200
Message-ID: <20e6fc5f-54ba-951c-efaf-b3629c8f75a0@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <8dfe0935d35b8a218ebf39d37113e27289a0de9b.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004141251.4e82378e@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20161004141251.4e82378e@free-electrons.com>
Sender: linux-clk-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: vinod.koul@intel.com, maxime.ripard@free-electrons.com, wens@csie.org, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lee.jones@linaro.org, mark.rutland@arm.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com, alexandre.belloni@free-electrons.com
List-Id: alsa-devel@alsa-project.org

Hello Thomas,


On 04/10/2016 14:12, Thomas Petazzoni wrote:
> Hello,
>
> On Tue,  4 Oct 2016 11:46:15 +0200, Mylène Josserand wrote:
>> Add the flag CLK_SET_RATE_PARENT to 'ac-dig' clock.
>
> There is no need to repeat the commit title inside the commit log
> itself. What would be more useful is to explain *why* this is needed.


Agreed, I will update it for a V2.

Thanks !

-- 
Mylène Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

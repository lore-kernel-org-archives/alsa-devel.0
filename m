From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Add BUG() assertion if max98088_get_channel
 returns -EINVAL
Date: Fri, 30 Sep 2011 13:56:09 +0100
Message-ID: <20110930125609.GK5366@opensource.wolfsonmicro.com>
References: <1317218471.8008.3.camel@phoenix>
 <4E83AA77.9040700@gmail.com>
 <20110929103413.GK3697@opensource.wolfsonmicro.com>
 <4E84FBA6.40600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E84FBA6.40600@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Mallon <rmallon@gmail.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, Peter Hsiang <peter.hsiang@maxim-ic.com>, Jesse Marroquin <jesse.marroquin@maxim-ic.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2011 at 09:13:42AM +1000, Ryan Mallon wrote:

> How about something like this (untested) patch?

Looks plausible.

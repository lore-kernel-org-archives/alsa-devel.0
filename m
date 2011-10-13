From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ak4535: fixup cache register table
Date: Thu, 13 Oct 2011 12:15:25 +0100
Message-ID: <20111013111525.GG5193@opensource.wolfsonmicro.com>
References: <1318497427.2857.14.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1318497427.2857.14.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 13, 2011 at 05:17:06PM +0800, Axel Lin wrote:
> ak4535_reg should be 8bit, but cache table is defined as 16bit.

Applied, thanks.

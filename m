From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: ad193x: Use snd_soc_update_bits for
 read-modify-write
Date: Mon, 17 Oct 2011 22:37:58 +0100
Message-ID: <20111017213757.GA5200@opensource.wolfsonmicro.com>
References: <1318582919.19976.1.camel@phoenix>
 <1318582987.19976.2.camel@phoenix>
 <20111014191000.GB2931@opensource.wolfsonmicro.com>
 <CAF+7xWmdNqEuVCNB=53FftFm_Ds-=o5DwVa41MDq8m0DTZnzxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF+7xWmdNqEuVCNB=53FftFm_Ds-=o5DwVa41MDq8m0DTZnzxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Barry Song <21cnbao@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 15, 2011 at 11:21:49AM +0800, Axel Lin wrote:

> But if you prefer also convert it to snd_soc_update_bits, I can do it.
> Let me know if I need to send a v2 for it.

It'd be nice, if only because the patch clearly isn't doing what the
changelog claims it's doing.

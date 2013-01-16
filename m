From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsi: Remove __devinitconst
Date: Wed, 16 Jan 2013 20:29:09 +0900
Message-ID: <20130116112907.GD25480@opensource.wolfsonmicro.com>
References: <1358334585-25046-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1358334585-25046-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 16, 2013 at 12:09:45PM +0100, Thierry Reding wrote:
> __devinitconst and friends have recently been removed and must not be
> used anymore.

Applied, thanks.

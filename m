From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: mc13783: Remove mono support
Date: Thu, 6 Sep 2012 08:17:37 +0800
Message-ID: <20120906001735.GR10580@opensource.wolfsonmicro.com>
References: <1346688253-29047-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F0131264F09
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 02:17:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1346688253-29047-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: philippe.retornaz@epfl.ch, alsa-devel@alsa-project.org, kernel@pengutronix.de, gcembed@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 03, 2012 at 01:04:13PM -0300, Fabio Estevam wrote:
> Playing a mono track on a mc13783 codec results in incorrect playback rate.
> 
> Remove mono support so that a mono track can be played correctly.

Applied, thanks.

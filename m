From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8985: Initial driver
Date: Wed, 15 Sep 2010 16:15:19 +0100
Message-ID: <20100915151519.GE4254@rakim.wolfsonmicro.main>
References: <1284560600-27978-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AF95F244BC
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Sep 2010 17:15:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284560600-27978-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 15, 2010 at 03:23:20PM +0100, Dimitris Papastamos wrote:
> The WM8985 is a low power, high quality, feature-rich stereo
> CODEC designed for portable multimedia applications that
> require low power consumption and high quality audio.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Applied, thanks.

>  sound/soc/codecs/wm8985.c | 1195 +++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/wm8985.h | 1046 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 2241 insertions(+), 0 deletions(-)

As discussed I added the Makefile and Kconfig entries as I did so.

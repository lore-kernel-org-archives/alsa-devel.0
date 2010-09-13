From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/11] sound: Remove pr_<level> uses of
	KERN_<level>
Date: Mon, 13 Sep 2010 09:25:42 +0100
Message-ID: <20100913082542.GB16606@rakim.wolfsonmicro.main>
References: <cover.1284267142.git.joe@perches.com>
	<27a88f64b5bfec16c8abf5aca89b7a1b7533ecb9.1284267142.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5F869245DF
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Sep 2010 10:25:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <27a88f64b5bfec16c8abf5aca89b7a1b7533ecb9.1284267142.git.joe@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: cbe-oss-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, Jiri Kosina <trivial@kernel.org>, Geoff Levand <geoff@infradead.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 11, 2010 at 10:10:59PM -0700, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  sound/ppc/snd_ps3.c         |    2 +-
>  sound/soc/s3c24xx/s3c-dma.c |    3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

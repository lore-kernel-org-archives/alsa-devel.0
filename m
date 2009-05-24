From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 3/9] Rename the PSC functions to DMA
Date: Sun, 24 May 2009 12:15:13 +0100
Message-ID: <20090524111512.GD4933@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231301.17919.88294.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D104424351
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 13:15:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090523231301.17919.88294.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 23, 2009 at 07:13:01PM -0400, Jon Smirl wrote:
> Rename the functions in the mpc5200 DMA file from i2s based names to dma ones to reflect the file they are in.

I'm OK with both these refactoring patches if Grant is - Grant, if I
could get your ack I'd like to merge these as soon as possible since
they're very big changes and it'd cut down on review effort.

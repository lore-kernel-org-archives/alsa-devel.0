From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 3/4] Support for AC97 on Phytec pmc030
	base board.
Date: Mon, 25 May 2009 10:48:08 +0100
Message-ID: <20090525094724.GC18290@sirena.org.uk>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013851.3073.79847.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 06129103836
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 11:48:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090525013851.3073.79847.stgit@terra>
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

On Sun, May 24, 2009 at 09:38:51PM -0400, Jon Smirl wrote:

> +static __exit void pcm030_fabric_exit(void)
> +{
> +}

Remove or implement, please.

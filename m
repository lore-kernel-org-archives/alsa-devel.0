From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/4] ASoC: uda1380: split set_dai_fmt into
	_both, _playback and _capture variants
Date: Wed, 4 Feb 2009 13:19:29 +0000
Message-ID: <20090204131928.GE29849@sirena.org.uk>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
	<20090203164132.GG23827@sirena.org.uk>
	<74d0deb30902030845h2320deafj7f66921b22f91069@mail.gmail.com>
	<200902040919.32728.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EC188243D2
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 14:19:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200902040919.32728.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 04, 2009 at 09:19:26AM +0200, Vasily Khoruzhick wrote:

> This patch breaks nothing for me, uda1380_set_dai_fmt_both was used in my 
> configuration.

Applied.

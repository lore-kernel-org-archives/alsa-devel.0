From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/10] soc - tlv320aic3x - Convert to use
	bulk registration APIs
Date: Tue, 13 May 2008 14:28:22 +0100
Message-ID: <20080513132821.GE21292@sirena.org.uk>
References: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080513153419.360c23e6.jarkko.nikula@nokia.com>
	<20080513162002.a7f8ccd7.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6577124B0A
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 15:28:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080513162002.a7f8ccd7.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 13, 2008 at 04:20:02PM +0300, Jarkko Nikula wrote:

> My own patch [1] fixed this problem. Thanks to new log message "Failed
> to add route Mono Out->MONOLOUT" :-)

Ah, excellent - that's already in ALSA so the patch series should apply
safely.  Thanks.

From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] General fix for Palm27x aSoC driver
Date: Wed, 15 Apr 2009 09:21:27 +0100
Message-ID: <20090415082127.GA29399@sirena.org.uk>
References: <200904121858.42931.marek.vasut@gmail.com>
	<200904122051.19335.marek.vasut@gmail.com>
	<20090414195035.GA6902@sirena.org.uk>
	<200904142342.34914.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 819112434A
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 10:21:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904142342.34914.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 14, 2009 at 11:42:34PM +0200, Marek Vasut wrote:

> OK, shall I change it and resend (ps. to what if you dont mind telling me?) ? 

pxa2xx_audio_ops_t

> Also, do you want to push it through also tree or ARM tree ? I'm for the 
> second option as it's more of a bugfix suitable for that tree.

ARM.

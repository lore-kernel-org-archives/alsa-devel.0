From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC, TWL4030 Register defaults
Date: Thu, 20 Nov 2008 11:23:05 +0000
Message-ID: <20081120112304.GB4539@sirena.org.uk>
References: <ef0d8a250811200319kd1afdf8r74d09d54e37b830c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A2FAA2412E
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 12:23:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ef0d8a250811200319kd1afdf8r74d09d54e37b830c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 04:49:33PM +0530, naveen krishna ch wrote:

> [PATCH] Register default values for gain, path selection for various input
> and output devices
> From:
> chnaveenkrishna <chnaveen@chnaveen.mistral.in>
>   To:
> Date:
> Today 04:49:50 pm

Something (your MUA)?  Is mangling this really badly...

As I said in reply to your first mail I'd really like to see some sort
of explanation as to why you are making these changes - are the defaults
in the existing driver wrong?  There seem to be an awful lot of changes
here and there's no discussion in the patch as to what they mean.

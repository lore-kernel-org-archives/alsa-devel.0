From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: AIC23 SOC Driver on OSK5912
Date: Tue, 7 Oct 2008 12:54:51 +0100
Message-ID: <20081007115450.GD19835@sirena.org.uk>
References: <e762f7a90810070448g6eb4545ay340e6be8de775133@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A2FF324546
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 13:55:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e762f7a90810070448g6eb4545ay340e6be8de775133@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jesslyn Abdul Salam <jesslyn.abdulsalam@gmail.com>
Cc: alsa-devel@alsa-project.org, Arun KS <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 07, 2008 at 05:18:55PM +0530, Jesslyn Abdul Salam wrote:

> I have been trying to use the AIC23 ALSA SoC driver for OSK5912 for the past
> few days. I got the driver patch from the linux-omap/alsa-devel mailing
> lists. The driver got compiled along just fine. But when the kernel boots,
> no sound cards have been listed.

CCing in Arun KS <arunks@mistralsolutions.com> who contributed that
support.

> Advanced Linux Sound Architecture Driver Version 1.0.17.

> ASoC version
> 0.13.2
> AIC23 Audio Codec
> 0.1
> MCLK = 12000000 [12000000], usecount =
> 0
> ALSA device
> list:
>     No soundcards
> found.

> Any one have tested this before ?

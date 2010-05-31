From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] alsa/Au1xxx-PSC: use resource_size
Date: Mon, 31 May 2010 12:08:05 +0100
Message-ID: <20100531110805.GE3489@rakim.wolfsonmicro.main>
References: <4BFF33B3.1040506@gmail.com>
	<AANLkTil1hKb8QdsKEfHseOyPdw8uIY6d5mVEUwZ68T-p@mail.gmail.com>
	<AANLkTimQD4TihG2yGsPLGmCmWV968fdoDtZ1nDcW5A-h@mail.gmail.com>
	<4BFF5838.8050403@gmail.com>
	<AANLkTikn3BHn1D3uVQWO6Xuiv4vkk8pMe96F7uUUSAmM@mail.gmail.com>
	<4BFF633B.7030101@gmail.com>
	<AANLkTim9C08G5iOuKE9XOtFRlS616c6yk-7LNLddbVCl@mail.gmail.com>
	<4BFF87DC.4010300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BE272442F
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 13:08:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BFF87DC.4010300@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, May 28, 2010 at 05:07:40PM +0800, Wan ZongShun wrote:
> Dear Mark & Liam,
> 
> alsa Au1xxx-PSC use resource_size.
> 
> Manuel has agreed this following version patch, now, can it be merged?

This has wordwrap issues and won't apply, please resend.  As I said
previously please also try to follow Documentation/SubmittingPatches
(eg, don't have non-changelog text above the --- in the mail and use a
standard prefix for the subject line).

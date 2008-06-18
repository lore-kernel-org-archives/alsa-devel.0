From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: looping S/PDIF data
Date: Wed, 18 Jun 2008 09:24:59 +0200
Message-ID: <4858B84B.4030800@keyaccess.nl>
References: <20080531112606.5884a1c9@mjolnir.drzeus.cx>
	<20080617215504.3203a5ed@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id CEA40243D6
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 09:24:31 +0200 (CEST)
In-Reply-To: <20080617215504.3203a5ed@mjolnir.drzeus.cx>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: ALSA devel <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, mulix@mulix.org
List-Id: alsa-devel@alsa-project.org

On 17-06-08 21:55, Pierre Ossman wrote:

> Ping
> 
> On Sat, 31 May 2008 11:26:06 +0200
> Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> 
>> I have a minor annoyance with the snd_trident driver that I was hoping
>> you might have a fix for:
>>
>> Pausing the output does not seem to take on the S/PDIF output. Analog
>> outputs properly stop in their tracks, but the S/PDIF port keeps
>> looping the current data buffer, which gives a rather unpleasant end
>> result. :)

Try the alsa-devel list...

Rene.

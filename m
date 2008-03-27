From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: ESI Juli@/Ice1724
Date: Thu, 27 Mar 2008 08:13:32 +0100
Message-ID: <47EB491C.3050506@insite.cz>
References: <dbfa5dfc0803262347y71a7a22p27ea2a2b133c9946@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 457ED2441F
	for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2008 08:13:38 +0100 (CET)
In-Reply-To: <dbfa5dfc0803262347y71a7a22p27ea2a2b133c9946@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Trompell <mark@foresightlinux.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,


The discussed problems were about opening the MIDI device. It seems 
unlikely audacity would be touching midi.

Did you use the new driver in HG repository? I tested recording with 
arecord.

Pavel.

Mark Trompell wrote:
> Hi,
> when, trying to use audacity for recording, my system completly hangs.
> I wonder if this is the problem descriped in
> http://mailman.alsa-project.org/pipermail/alsa-devel/2007-April/000563.html
> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-February/005987.html
> and maybe
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1860
> 
> Is it already fixed or is this bug still there?
> Regards
> Mark
> 
> P.S I'm not subcribed to the list, so please cc me.

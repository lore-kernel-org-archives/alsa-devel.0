From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 14 Apr 2008 18:40:37 +0200
Message-ID: <20080414164036.GC22115@tango.0pointer.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<480099C6.3040708@superbug.co.uk>
	<20080412133536.GC32491@tango.0pointer.de>
	<4800FC14.3060804@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 39BAD2455D
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 18:40:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4800FC14.3060804@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 12.04.08 19:14, James Courtier-Dutton (James@superbug.co.uk) wrote:

> That sounds reasonable for now. Professional sound card users will maybe 
> just have to remember to mute the master control before connecting their 
> speakers.
> 
> I don't understand why your sound card is OK at -40dB but too loud at 
> -41dB. It does not make any sense. There must be a bug there, because 
> -41dB should be quieter than -40dB.

Sorry, this is not what I wanted to say. All I wanted to say is that
-40dB and 41db are both fine. But higher values become rapidly very,
very loud. 

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4

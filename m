From: Florian Faber <faber@faberman.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sun, 13 Apr 2008 13:26:31 +0200
Message-ID: <200804131326.31800.faber@faberman.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<75b66ecd0804121624m308977dy752d7e7c41dd7ea3@mail.gmail.com>
	<4801E5CA.7010408@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de
	(static-ip-85-25-152-101.inaddr.intergenia.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 261012465C
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Apr 2008 13:26:51 +0200 (CEST)
In-Reply-To: <4801E5CA.7010408@superbug.co.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sunday 13 April 2008 12:51:54 James Courtier-Dutton wrote:

> Are the output levels from the line out/speaker out connectors really
> any different between pro and cheap sound card?

The electric levels do differ. But that's not the point. The point is 
that you usually have active speakers and 0dB means full throttle. You 
don't have anything to alter the volume between the sound card and the 
speakers.

To give you an impression: My main out is -40..-36dB for work. If I want 
to talk to another person in the same room, I have to dim to -46dB max. 
If I throw a party, it might go up to -20..-15dB. 0dB will just pop out 
the ear drums.

> It seems to me that whatever way you look at this, A default value of
> "MUTE" is really the only safe level for all sound card types.

Yes. 


Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net

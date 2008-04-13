From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sun, 13 Apr 2008 13:09:23 +0100
Message-ID: <4801F7F3.104@superbug.co.uk>
References: <20080411204610.GA32413@tango.0pointer.de>	<75b66ecd0804121624m308977dy752d7e7c41dd7ea3@mail.gmail.com>	<4801E5CA.7010408@superbug.co.uk>
	<200804131326.31800.faber@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net
	[194.217.242.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B19F24673
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Apr 2008 14:09:25 +0200 (CEST)
In-Reply-To: <200804131326.31800.faber@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Florian Faber wrote:
> On Sunday 13 April 2008 12:51:54 James Courtier-Dutton wrote:
>
>   
>> Are the output levels from the line out/speaker out connectors really
>> any different between pro and cheap sound card?
>>     
>
> The electric levels do differ. But that's not the point. The point is 
> that you usually have active speakers and 0dB means full throttle. You 
> don't have anything to alter the volume between the sound card and the 
> speakers.
>
> To give you an impression: My main out is -40..-36dB for work. If I want 
> to talk to another person in the same room, I have to dim to -46dB max. 
> If I throw a party, it might go up to -20..-15dB. 0dB will just pop out 
> the ear drums.
>
>   
All active speakers act as a combined amp and speaker.
If you have a 50W active speaker, your -36dB for work might be right.
But, if you have a 300W active speaker, your -36dB will probably be way 
too loud.
This is essentially my point that the sound card cannot really decide 
which is a sensible level to output.

James

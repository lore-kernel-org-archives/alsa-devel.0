From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: cs46xx experimental DSP drivers
Date: Tue, 24 Sep 2002 17:33:41 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020925003341.GA990@porky>
References: <3D8F7F59.6030105@prism.gatech.edu> <3D90A8D8.7070103@cucumelo.org> <3D90B54F.20402@prism.gatech.edu> <3D90D641.7050200@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D90D641.7050200@cucumelo.org>; from gorm@cucumelo.org on Tue, Sep 24, 2002 at 14:16:49 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2002.09.24 14:16 Benny Sjostrand wrote:
> Finally, so far I know the Santa Cruz is yet another card where we dont 
> have  technical specifications. It's possible that there is any GPIO or 
> whatever kind of logic that controls "something" that makes the sound 
> better.
> Not having a Santa Cruz card dont make things easier ... I had one I 
> would start testing all the EGPIO's by the hard way seing what happens, 
> (maybe
> someone that have time and such a card can do this ?) In the current 
> cs46xx driver there is some debug code to control the EGPIO's from the
> ALSA mixer that can be activated by defining 
> CONFIG_SND_CS46XX_DEBUG_GPIO in cs46xx_lib.c, that I've been using to 
> test EGPIO functionality on
> the Game Theater XP card.


    I've tried contacting Turtle Beach regarding this, and they wouldn't
release any information. I tried contacting VideoLogic, but they said they
could release any of the info on the Sonic Fury, since it's owned by
Turtle Beach.
    I had noticed earlier that you mentioned some code to control the EGPIO
pins, but when you didn't talk about it further, I incorrectly assumed it
was some code for personal use. Good to hear otherwise. =o)   I don't have
alot of time to spare, and I'm not very skilled in this area, but I'll
definitely give this a shot. Any advice that might make my attempt easier
or more profitable?


-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

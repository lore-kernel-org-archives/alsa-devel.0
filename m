From: David Sankel <camio@yahoo.com>
Subject: Re: 1.0.0 Requirements, Integration of sound deamon (JACK)
Date: Sat, 12 Oct 2002 19:52:39 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021013025239.17302.qmail@web40603.mail.yahoo.com>
References: <3DA6E82F.4070302@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DA6E82F.4070302@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Have you used JACK?
> 
> AFAIK it definitely requires a pcm. You may have
> used it on hardware 
> that supports multiopen which would explain what you
> have observed.

Yes, I have used jack.  I meant that it doesn't open
the sound device when it is not being used by a host application.

__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

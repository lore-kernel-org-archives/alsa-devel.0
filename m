From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: anybody else OK with current CVS *and* SMP?
Date: Thu, 7 Aug 2003 09:18:25 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030807081825.15599.qmail@web40603.mail.yahoo.com>
References: <3F31FDB1.8070804@mindcom.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F31FDB1.8070804@mindcom.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Antti Boman <antti.boman@mindcom.fi>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Antti Boman <antti.boman@mindcom.fi> wrote:
> Ok, there's a difference compared to my problem. My
> computer locks up 
> within a couple of seconds. So, obviously we're not
> talking about the 
> same problem. Also, I have to install newer ALSA and
> JACK to see if the 
> lock-up is still there.

That's interesting. I use CVS ALSA and SMP (although
not JACK), and I have been having lock-ups too ever
since last Sunday evening (3rd August). However, at
least some of my lock-ups must be hardware related
because I've had a horrible time fscking my root
partition afterwards. (But THAT could be caused
because I can't load my CPUs' microcode until the root
partition is mounted OK...).

I shall try removing ALSA and seeing if that improves
thing. It would be just my luck to have multiple
lock-up problems all at once!

Chris


________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://uk.messenger.yahoo.com/


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

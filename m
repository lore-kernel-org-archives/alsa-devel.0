From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: Two sound cards, only sound out of one
Date: Fri, 29 Aug 2003 16:57:19 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030829165719.68400c00.erikd-alsa@mega-nerd.com>
References: <20030824121353.06de39c8.erikd-alsa@mega-nerd.com>
	<s5hptiu80km.wl@alsa2.suse.de>
	<20030829132114.4f0ef4f6.erikd-alsa@mega-nerd.com>
	<1062130583.3028.0.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1062130583.3028.0.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Aug 2003 21:16:23 -0700
Mark Knecht <markknecht@comcast.net> wrote:

> I'm sure you've tried this, but if the card that doesn't work in this
> configuration is the only card in the system, does it work?

I'm sure I had tried this, but I thought i would try it again.

Got inside the box, unplugged the good card, tried the other one, no good, 
unplugged the bad card, plugged in the good card, still no good, plugged 
in both cards, still no good. Scrounged around for another Es1371 based 
card, plugged that in by itself and it worked.

Anyway to cut a long story short, after about 200 reboots and at least
twice that in plugging/unplugging cards, I have the original two cards
in the machine, in their two original slots and they both work.

I have no idea what the problem was. If it ever happens again, I won't
know how to fix it.

Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
"An older MS internal whitepaper from August 2000 on switching 
Hotmail, which MS acquired in 1997, from front-end servers 
running FreeBSD and back-end database servers running Solaris 
to a whole farm running Win2K, reads like a veritable sales 
brochure for UNIX" 
-- http://www.theregister.co.uk/content/4/28226.html


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

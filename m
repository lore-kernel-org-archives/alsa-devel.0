From: Forest Bond <f_a_b@softhome.net>
Subject: writing driver for MOTU PCI 324, 2408 MK-II
Date: Sun, 8 May 2005 12:14:25 -0400
Message-ID: <20050508161425.GD25855@localhost.localdomain>
Reply-To: Forest Bond <f_a_b@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello all,

I'm new to the list.  Joined up because I've decided I want to write a 
driver for the Mark of the Unicorn PCI-324 PCI card.  This card allows a 
variety of MOTU external interfaces to be used.  I own a MOTU 2408 MK 
II, an 8 channel interface.  This (and similar interfaces from MOTU) are 
common in the pro audio world.

I have emailed MOTU tech support, but have not gotten a response.  I 
have a feeling this will be the case in the future, as well.  MOTU has 
strong ties with Apple.

I've searched the list archive, and, from what I can see, noone has 
begun work on a driver for these interfaces.  It may not be feasible, 
given the lack of technical information available (yeah, yeah, I know, 
welcome to the wonderful world of linux driver development).  If, 
however, anyone is aware of an attempt to write a driver, please let me 
know.  Also, if anyone is interested in pitching in, send me an email.

I have limited experience writing drivers (well, next to none, 
actually), but I'm gonna give it a shot anyway.

Couple of questions:

Can released ASIO drivers be used to gather technical information on the 
hardware?

Are there any good techniques for probing the hardware and discovering 
necessary technical info?

Any help would be appreciated.

Thanks!
Forest


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20

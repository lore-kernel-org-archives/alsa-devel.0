From: Florin Andrei <florin@andrei.myip.org>
Subject: Re: limits
Date: 07 Jun 2004 12:36:20 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1086636979.3260.17.camel@rivendell.home.local>
References: <Pine.HPX.4.33n.0406070926050.6374-100000@studcom.urz.uni-halle.de>
Reply-To: alsa-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0406070926050.6374-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-06-07 at 00:43, Clemens Ladisch wrote:
> Florin Andrei wrote:

> > What's the max number of MIDI ports that's supported by ALSA?
> 
> There can be up to 8 rawmidi devices per card, but each device can
> have an unlimited number of subdevices.

What does that mean in plain english? Does it mean that i can hook up
max 64 MIDI devices to my system?
What's the difference between rawmidi device and subdevice, from a
user's perspective?

-- 
Florin Andrei

http://florin.myip.org/



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org

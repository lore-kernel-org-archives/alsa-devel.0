From: Florian Bomers <Florian.Bomers@sun.com>
Subject: Re: sblive midi out
Date: Mon, 04 Nov 2002 15:19:23 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC7007B.C0490C59@sun.com>
References: <Pine.LNX.4.44.0211042051560.9000-100000@rhubarb.custard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ian <deviant@custard.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have several SB Live's and even a Dell OEM one, and all of them have
functional external MIDI i/o. I haven't tried with latest ALSA drivers though.
You might want to search alsa-devel and alsa-user mailing lists, there were some
recent sb live issues.

Florian

ian wrote:
> 
> Thanks for the answer on my dlmisc.c problem - updating sorted that out.
> I have an sblive oem that came with my dell, that has no digital output
> board. Alsa-lib reports that it is possible to writeto the midi port, but
> trying to do so reports that there is no such device. I believe the
> joystick connector on the back of the card can only be used for midi
> input, but i might be wrong there. At any rate it would seem that the
> sblive driver is doing something wrong?
> Ian
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: ApacheCon, November 18-21 in
> Las Vegas (supported by COMDEX), the only Apache event to be
> fully supported by the ASF. http://www.apachecon.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com

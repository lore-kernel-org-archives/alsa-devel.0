From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Strange things with via82xx
Date: Wed, 23 Jun 2004 10:26:10 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406231024580.4564-100000@studcom.urz.uni-halle.de>
References: <200406222045.55079.monge@sns.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200406222045.55079.monge@sns.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Maurizio Monge <monge@sns.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Maurizio Monge wrote:
> when using linux OSS or WinXP 32bits (if i remember correctly, as i deleted
> it :-) ), to listen audio i have to connect the loudspeakers
> to the red "Microphone jack" (!!!).
>
> When using FreeBSD 32bits (OSS) or ALSA i have to connect the loudspeakers to
> the light green "Out Jack".
>
> This looks very strange!
>
> Further, when using WinXP, linux OSS or FreeBSD i get a MUCH better quality
> than with ALSA (cshhhhhhhhhhhhhhhhh).
> Of course i tried dxs_support=0,1,2,3,4 but the sound quality do not changes.

What codec does your MB use? (see second line at the top of the
alsamixer screen)


Regards,
Clemens




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

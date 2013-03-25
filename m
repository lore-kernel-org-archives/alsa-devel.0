From: Clemens Ladisch <cladisch@googlemail.com>
Subject: Re: [alsa-devel] Audio-gd NFB-17.32 (VIA VT1731)
Date: Mon, 25 Mar 2013 08:38:16 +0100
Message-ID: <514FFEE8.4070300@googlemail.com>
References: <20130322215650.GF7539@pvv.ntnu.no>
	<514DD773.8060408@guest.arnes.si> <514E3778.1050801@guest.arnes.si>
	<20130324205326.GB776@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <20130324205326.GB776@pvv.ntnu.no>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Torstein Hegge <hegge@resisty.net>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Torstein Hegge wrote:
> I think we can conclude that the VIA VT1731 has the same issue as the
> C-Media CM6631.
>
> I'll add the VT1731 as one of the devices that needs a reset after
> sample rate change in the next iteration of the sample rate workaround
> patch.

Why not just do it for all UAC 2 devices?


Regards,
Clemens

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar

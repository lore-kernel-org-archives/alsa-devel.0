From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: future ALSA development
Date: Tue, 24 Jun 2003 00:22:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EF77D90.5080209@folkwang-hochschule.de>
References: <Pine.LNX.4.44.0306231338350.1838-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from kuwiserv.folkwang-hochschule.de (kuwiserv.folkwang-hochschule.de [193.175.156.250])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA17639
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2003 23:22:50 +0200
In-Reply-To: <Pine.LNX.4.44.0306231338350.1838-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
 >>
 >>other people might propose XML.  then it becomes to a question whether=

 >>alsa-lib should rely on other libs...
 >
 >
 > I think that XML is too overkill for our purposes.
 >
 > 						Jaroslav
 >

true if you only consider alsa. but on most systems, libxml2 is there=20
anyway. <underwear type=3D"asbestos">and imvho xml is less a matter of=20
taste than lisp.</underwear> and xml is way easier to handle in other=20
contexts (i'm thinking of auto.configuration stuff etc.)
otoh, the embedded guys will probably not like it, but then memory is=20
becoming cheaper by the minute, and its additional size will be a moot=20
point in the very near future.



--=20
All Members shall refrain in their international relations from
the threat or use of force against the territorial integrity or
political independence of any state, or in any other manner
inconsistent with the Purposes of the United Nations.
	-- Charter of the United Nations, Article 2.4


J=F6rn Nettingsmeier
Kurf=FCrstenstr 49, 45138 Essen, Germany
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)






-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php

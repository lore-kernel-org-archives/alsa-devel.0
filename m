From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: status of powermac sound?
Date: Wed, 12 May 2004 12:31:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1084357911.3034.11.camel@thor.asgaard.local>
References: <200405121138.09878.bergtroll@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200405121138.09878.bergtroll@gmx.li>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Niklas Werner <bergtroll@gmx.li>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-05-12 at 01:38, Niklas Werner wrote:
> 
> is there any progress on the status of full support for the newer devices 
> as snapper, etc (in the AlBooks,..). I'm running the 2.6.5 benh-kernel 
> from bitkeeper and basically the sound only works reliably when using the 
> oss emulation.
> 
> I can remember a short time under 2.6.* when alsa output actually worked, 
> though...

I have a

0 [Snapper        ]: PMac Snapper - PowerMac Snapper
                     PowerMac Snapper (Dev 26) Sub-frame 0

in a TiBook IV, and it's been working better than OSS ever did for quite
a while. My configuration is http://penguinppc.org/~daenzer/asound.conf

The only thing that bothers me is
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000057, but I can live with it.


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3

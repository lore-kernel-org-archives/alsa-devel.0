From: m <m@iriXx.org>
Subject: Re: rc4 lib - build failing
Date: 23 Oct 2002 09:37:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1035362233.3179.10.camel@hamish.iriXx.org>
References: <Pine.LNX.4.33.0210230956460.5772-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0210230956460.5772-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

sure, its GNU ld version 2.11.92.0.12 20011121

should we upgrade our ld? it would explain a *lot* of problems i've had
with compiles if there is a faulty ld out there...

thanks

m


On Wed, 2002-10-23 at 08:57, Jaroslav Kysela wrote:
> Hi all,
> 
> 	could everybody with problems of building alsa library (undefined 
> symbol) send me version of ld? (ld --version)? I will try to add a 
> detection of faulty ld to the configure script. Thanks.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project  http://www.alsa-project.org
> SuSE Linux    http://www.suse.com
> 
> 
> 
> -------------------------------------------------------
> This sf.net emial is sponsored by: Influence the future 
> of Java(TM) technology. Join the Java Community 
> Process(SM) (JCP(SM)) program now. 
> http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
-- 
iriXx
www.iriXx.org

copyleft: creativity, technology and freedom?
info@copyleftmedia.org.uk
www.copyleftmedia.org.uk

 _
( )  ascii ribbon against html email
 X
/ \    cat /dev/sda1 > /dev/dsp


  *** stopping make sense ***



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en

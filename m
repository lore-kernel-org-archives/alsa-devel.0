From: m <m@iriXx.org>
Subject: Re: rc4 lib - build failing
Date: 23 Oct 2002 10:27:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1035365270.3175.22.camel@hamish.iriXx.org>
References: <Pine.LNX.4.33.0210231118160.5772-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0210231118160.5772-100000@pnote.perex-int.cz>
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

On Wed, 2002-10-23 at 10:22, Jaroslav Kysela wrote:
> On 23 Oct 2002, m wrote:
> 
> > sure, its GNU ld version 2.11.92.0.12 20011121
> 
> What is your distribution?

mandrake 8.2
> 
> > should we upgrade our ld? it would explain a *lot* of problems i've had
> > with compiles if there is a faulty ld out there...
> 
> Hmm. The situation seems to be more difficult.
> 
> ld 2.9.1.0.25	- does not work (SuSE 6.3)
> ld 2.10.0.33    - works (SuSE 7.1)
> 
> Perhaps, we have a specific patch for binutils..

hmm... yes, thats interesting.. 

could you please give me a url for the patch?

thanks

m~


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

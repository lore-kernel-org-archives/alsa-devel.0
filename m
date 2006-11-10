From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: SB16 ISA max frequency bump to 48kHz
Date: Fri, 10 Nov 2006 16:09:14 +0100
Message-ID: <4554961A.5070509@keyaccess.nl>
References: <455420809a154@wp.pl> <s5hirhncyyl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hirhncyyl.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Krzysztof Helt wrote:

>> This patch  bumps maximum frequency for ISA SB16 to 48kHz. I
>> tested it on three cards: SB16 non-pnp, SB16 pnp and SB AWE64
>> (all ISA boards).
> 
> Looks fine.  Could you give sign-off for commit?

Sorry, but I'd have to be very mistaken if the SB16 supports 48000 in 
hardware. The 4000-44100 is correct.

Rene

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

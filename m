From: Jan Depner <eviltwin69@cableone.net>
Subject: Re: writing user program for alsa under fedora core 1
Date: Sat, 29 May 2004 19:26:04 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1085876764.23479.1.camel@eviltwin>
References: <40B92479.3080303@cornfed.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40B92479.3080303@cornfed.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Frank W. Miller" <fwmiller@cornfed.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Your best bet is to download the sources and build the packages.  That
way you'll know exactly what you've got.  Also, at some point you may
have to go into the libraries and do some debugging.

Jan

On Sat, 2004-05-29 at 19:02, Frank W. Miller wrote:
> Greetings,
> 
> I'm writing a softphone for Linux under Fedora Core 1.  I've had this 
> client working well using OSS under Red Hat 9 for awhile now.  I've run 
> into some problems however when trying to use the OSS calls under 
> Fedora.  I thought I would try to just write an ALSA driver and went to 
> the Programming docs.  Trouble is, they reference a header file 
> <alsa/asoundlib.h> and this file doesnt exist in my Fedora core distro.  
> Do I need another RPM install or something?
> 
> Thanks,
> FM
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click

From: Brent Cook <busterbcook@yahoo.com>
Subject: Re: Re: RFC: OSS driver removal, a slightly different approach
Date: Fri, 20 Jan 2006 01:04:30 -0600
Message-ID: <0D5E76A0-FA1B-4CCC-BFA6-D84FBA1EE39D@yahoo.com>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <43D05D0C.1030900@keyaccess.nl>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp106.sbc.mail.mud.yahoo.com (smtp106.sbc.mail.mud.yahoo.com [68.142.198.205])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 0DDC2153
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 08:04:33 +0100 (MET)
In-Reply-To: <43D05D0C.1030900@keyaccess.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Jan 19, 2006, at 9:46 PM, Rene Herman wrote:

> Krzysztof Halasa wrote:
>
>>> SOUND_ADLIB
>> IIRC 8-bit sound, ISA. GUS on DOS used to emulate it
>
> Extremely classic card. Would be fun to still have around if only  
> for history's sake...

The Adlib card that I had was just an OPL-2 synthesizer, no PCM  
support at all. Normally, it was mono, 9 voices, 2 FM operators per  
voice + 3 noise channels, but there was a mode that supported 4  
operators and reduced the number of voices to 4 or 5.

An OPL-3 is just 2 OPL-2's, one for each stereo channel. I think that  
any card with an OPL-3 (SB-16) can act like an OPL-2, i.e. would be  
suitable for porting the driver. I really wish I still had my  
old .rol and .pat file collection; had a killer version of Bohemian  
Rhapsody.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

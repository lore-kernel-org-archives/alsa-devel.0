From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Hoontech C-Port ice1712 midi in
Date: Wed, 15 Feb 2006 10:23:31 +0100
Message-ID: <20060215092331.GC10387@ifiu25.informatik.uni-halle.de>
References: <20060214212401.D519412502@sc8-sf-spam2.sourceforge.net>
 <200602151009.43605.songshop@bizmedia.com.au>
 <1139959588.11659.163.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1139959588.11659.163.camel@mindpipe>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Geoff Beasley <songshop@bizmedia.com.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Wed, 2006-02-15 at 10:09 +0000, Geoff Beasley wrote:
> > Is there anything that can be done to get the midi-in on these devices 
> > funtional ?

It seems neither Hoontech nor the guy who wrote the Windows driver
remember how this card is wired.  I got the source code of the box
configuration program two years ago and changed the driver accordingly,
but it didn't help.  I'm not sure if the complete driver source does
exist anymore.

I guess the whole Windows driver would have to be reverse engineered.

> This is the first I've heard of it not working.  Where's the bug report?

Bugs 55 and 1161.


Regards,
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

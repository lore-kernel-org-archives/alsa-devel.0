From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: prealloc/buffer time limit?
Date: Mon, 13 Feb 2006 16:52:44 +0100
Message-ID: <20060213155244.GF9177@ifiu25.informatik.uni-halle.de>
References: <43ED016D.9030301@request.com>
 <20060213080655.GA8896@ifiu25.informatik.uni-halle.de>
 <43F0A0AB.3050102@request.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <43F0A0AB.3050102@request.com>
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
To: Ron Cococcia <ron.cococcia@request.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

A. Because it's contrary to the direction we normally read in.
Q. Why is top-posting so bad, then?
A. Top-posting.
Q. What's the biggest problem with readability on the Net?

Ron Cococcia wrote:
> I am referring to "prealloc_max_size", part of the ich_pcm_table
> struct for intel8x0.

Change appropriate fields in snd_intel8x0_stream, too.


HTH
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

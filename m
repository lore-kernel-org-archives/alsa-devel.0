From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Help Wanted?
Date: Wed, 01 Feb 2006 17:57:01 -0500
Message-ID: <1138834622.27434.103.camel@mindpipe>
References: <4345459A000A66C3@hawk.dcu.ie>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4345459A000A66C3@hawk.dcu.ie>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Cathal Mullaney <cathal.mullaney2@mail.dcu.ie>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-02-01 at 22:33 +0000, Cathal Mullaney wrote:
> Hullo All,
>    I am a recent CS graduate and have been developing C++ applications using
> alsa for a number of years now and would like, if possible, to give something
> back as it were. As I have been developing apps. with alsa over a variety
> of hardware architectures I have noticed a few bugs and unattractive features
> which I would be willing to attempt to address. This list seems a sortof
> I have a problem with "X" please help me, are there active projects within
> ALSA that require developers or should I identify a problem and focus my
> attention on it? I have no experience writing device drivers for Linux but
> I have read various faqs concerning kernel module programming etc and am
> willing to learn any necessary skills. I have a reasonable amount of free
> time to devote to such a worthy cause and am always willing to learn new
> skills. All I would ask in return is to be credited for anything I contribute.
> Anyone willing to put me to work please reply to my email address or to the
> list. 

Many, many people would be happy if you could fix the "Skype does not
work with aoss" bug.  It's tricky as the source code of Skype is not
available, but some people report that they can reproduce the issue with
some open source VOIP apps like kiax and wengophone.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1228

The bug seems to be hardware or system dependent - for some people it
just works.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

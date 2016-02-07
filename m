From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: About planning of libhinawa ITP to debian project
Date: Sun, 7 Feb 2016 12:10:17 +0900
Message-ID: <56B6B599.2020002@sakamocchi.jp>
References: <56ADEF9C.50303@sakamocchi.jp> <56ADF3E8.1050109@sakamocchi.jp>
	<56B0B751.9080609@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <56B0B751.9080609@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: hayashi@clear-code.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux1394-devel@lists.sourceforge.net, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Feb 2 2016 23:04, Takashi Sakamoto wrote:
> On Jan 31 2016 20:45, Takashi Sakamoto wrote:
>> In this message, I explain about a plan of libhinawa ITP[0] to debian
>> project. Fortunately, I got a help of a debian package maintainer,
>> Kentaro Hayashi. He maintains groonga package[1] and experienced
>> related works[2].
>>
>> Currently, we plan to work for it in next month, February 2016. I have
>> no idea about when FTP master acked to our ITP and when the package is
>> released from debian project.
> 
> Today, we register this to Debian Bug report #813474.
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=813474
> 
> And start RFS (Request For Sponsorship).
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=813489
> 
> Thanks for Kentaro.

A few days ago, we got a sponsor for the package and yesterday it's in
new queue. Today, a few hours before, I received a notification that the
package was granted and moved to Debian ftp-master server.

In short, the package is in unstable repository and may be released
within a few days. Thanks all.

Now I'm preparing for 'needs-packaging' request [3] to Ubuntu project.
We have 10 days to FeatureFreeze[4] for Ubuntu 16.04 (Xenyal Xerus)[5].

Regards

>> I with the package will be available as early as possible, and this work
>> will be a part of his great work as a debian package maintainer.
>>
>> FYI,
>>
>> [0] ITP = Intent To Packaging
>> [1] Debian -- Details of package groonga in sid:
>> https://packages.debian.org/sid/groonga
>> [2] Debian Bug report logs - #732055
>> ITP: groonga -- Fulltext search engine
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=732055

[3] https://wiki.ubuntu.com/UbuntuDevelopment/NewPackages
[4] https://wiki.ubuntu.com/FeatureFreeze
[5] https://wiki.ubuntu.com/XenialXerus/ReleaseSchedule


Takashi Sakamoto

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140

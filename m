From: asbjs@stud.ntnu.no (Asbjørn Sæbø)
Subject: Re: Q: Periodsize for capture, SBLive
Date: Tue, 19 Oct 2004 10:19:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041019081918.GB24099@stud.ntnu.no>
References: <200410190807.i9J87NmG000466@www6.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200410190807.i9J87NmG000466@www6.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 19, 2004 at 10:07:23AM +0200, Peter Zubaj wrote:
> > OK.  Any idea why I get 384?
> I think hardware can't do less. If you need less latency use hw:0,2
> and set more channel count (1, 2, 4, 8, 16, 32)

Thanks for your advice.  I do however not think I understand this fully.
Why will increasing the channel count give lower latency?

Asbj.S.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: More CS4630, secondary CODEC output.
Date: Wed, 31 Jul 2002 18:14:50 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020801011450.GC5646@porky>
References: <3D41D4DC.60004@cucumelo.org> <20020727003649.GA5560@porky> <3D4245A1.3020302@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gotnet.net (mail.gotnet.net [207.173.88.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA30590
	for <alsa-devel@alsa-project.org>; Thu, 1 Aug 2002 03:22:57 +0200
Content-Disposition: inline
In-Reply-To: <3D4245A1.3020302@cucumelo.org>; from gorm@cucumelo.org on Sat, Jul 27, 2002 at 00:02:57 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2002.07.27 00:02 Benny Sjostrand wrote:
>>    And to those with Santa Cruz cards, after my first (quick) test the 
>> rear
>> channel doesn't seem to work... yet.
> 
> Well, you dont seems to any luck ... no SPDIF, no rear sound -:(


    I just recalled something that may help with this problem. Crystal
released a driver that had support for the second codec; that driver worked
fine with my Santa Cruz, so we may be able to compare the setup and find
the problem.
    I'll start looking, but if anybody else wants to help feel free. The
Crystal driver is available at:

ftp1.cirrus.com
username: ftppclink
password: cSPxQMd

    It's under the folder "cs46xx-02a-secondcodec". Also, there's another
datasheet available that was previously on that FTP site, but has recently
been removed. If anyony would like a copy, you can e-mail me for one. It
contains very useful documentation on the CS4630.


-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31

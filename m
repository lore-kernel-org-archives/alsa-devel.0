From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Audigy 2 support, was Re: alsa "Soundcard" support
 page on alsa-project.org
Date: Thu, 20 May 2004 12:38:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40AC98BB.7080901@superbug.demon.co.uk>
References: <40ABEC93.9080309@superbug.demon.co.uk> <200405191644.14991.witzel.thomas@comcast.net> <40AC1053.6000808@superbug.demon.co.uk> <200405200229.46724.witzel.thomas@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200405200229.46724.witzel.thomas@comcast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: witzel.thomas@comcast.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas Witzel wrote:
> On Wednesday 19 May 2004 08:56 pm, James Courtier-Dutton wrote:
> 
>>>We have been trying very hard to get Creative to release some
>>>datasheets, but things are taking a very long time.
>>>
>>>So, if you have time, try to discover how the P16V chip works and tell us.
> 
> 
> What would be a good starting point ? Is there any documentation at all ? I 
> noticed that this so called kX project got it to work and they claim to have 
> found out the name "P16V" from the driver at opensource.creative.com. But 
> there is really nothing there.
> 
> 											Thomas

There is no documentation at all. It will be a real voyage of discovery!
The kX project has the datasheets under NDA, so they won't help us.

Some low level reverse engineering is required. Just like everyone else 
has had to do to get the current Creative SB Live and Audigy to work in 
Linux.
Getting that P16V chip working would let us actually use those 24bit 
codecs, instead of being limited to 16bit at the moment.

Cheers
James



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click

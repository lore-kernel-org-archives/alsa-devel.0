From: Frank Barknecht <fbar@footils.org>
Subject: Re: The date of releasing 1.0.8
Date: Tue, 11 Jan 2005 01:21:41 +0100
Message-ID: <20050111002141.GE13505@fliwatut.scifi>
References: <A3E6EF77AFE291498B01A47D64B04636025DA160@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <A3E6EF77AFE291498B01A47D64B04636025DA160@orsmsx403.amr.corp.intel.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo,
Lee, TommyX C hat gesagt: // Lee, TommyX C wrote:

> Please tell me the most stable music players for testing the playback
> functionality of ALSA drivers. I am now using XMMS and aplay on RHEL3u3.

IMO aplay/arecord is the canonical tool to test ALSA. If aplay doesn't
work, something is really wrong.

XMMS however in the past had rather bad ALSA support, at least with
some of the more "difficult" cards like those based on the
ICE-chipsets. I don't know, if this is still valid, but I don't trust
my ogg files to xmms anymore. ;)

XMMS is nice to test OSS emulation compatibility, though. I still like
the good old alsaplayer the most as a general purpose player with good
ALSA support. Another important test is Jack (jackit.sf.net).

Ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
